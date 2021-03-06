use gleam::gl;
use glutin::{Api, ContextBuilder, ControlFlow, Event, EventsLoop, GlRequest, WindowBuilder, WindowEvent};

use std::collections::HashMap;
use std::time::Instant;

#[macro_use]
extern crate lazy_static;

mod shader_source {
    include!(concat!(env!("OUT_DIR"), "/shaders.rs"));
}

fn compile_shader(gl: &dyn gl::Gl, shader: &shader_source::Shader) -> u128 {
    let start_time = Instant::now();

    let vert = gl.create_shader(gl::VERTEX_SHADER);
    gl.shader_source(vert, &[shader.vert.as_bytes()]);
    gl.compile_shader(vert);

    let mut status = [0];
    unsafe { gl.get_shader_iv(vert, gl::COMPILE_STATUS, &mut status); }
    if status[0] == 0 {
        let log = gl.get_shader_info_log(vert);
        println!("Failed to compile {} vertex shader: {}", shader.name, log);
    }

    let frag = gl.create_shader(gl::FRAGMENT_SHADER);
    gl.shader_source(frag, &[shader.frag.as_bytes()]);
    gl.compile_shader(frag);

    let log = gl.get_shader_info_log(frag);
    let mut status = [0];
    unsafe { gl.get_shader_iv(frag, gl::COMPILE_STATUS, &mut status); }
    if status[0] == 0 {
        println!("Failed to compile {} fragment shader: {}", shader.name, log);
    }

    let prog = gl.create_program();
    gl.attach_shader(prog, vert);
    gl.attach_shader(prog, frag);

    gl.link_program(prog);

    let end_time = Instant::now();
    let elapsed_time = end_time.duration_since(start_time).as_micros();

    let mut link_status = [0];
    unsafe { gl.get_program_iv(prog, gl::LINK_STATUS, &mut link_status); }

    if link_status[0] != 0 {
        println!("Compiling shader {} took {}ms", shader.name, elapsed_time as f32 / 1000.0);
    } else {
        let log = gl.get_program_info_log(prog);
        println!("Compiling shader {} failed: {}", shader.name, log);
    }

    gl.detach_shader(prog, vert);
    gl.detach_shader(prog, frag);
    gl.delete_shader(vert);
    gl.delete_shader(frag);
    gl.delete_program(prog);

    elapsed_time
}

fn main() {
    let mut event_loop = EventsLoop::new();
    let wb = WindowBuilder::new().with_title("Hello GL!");

    let context = ContextBuilder::new()
        .with_gl(GlRequest::Specific(Api::OpenGlEs, (3, 0)))
        .build_windowed(wb, &event_loop)
        .unwrap();

    let context = unsafe { context.make_current().unwrap() };

    let gl = unsafe { gl::GlesFns::load_with(|s| context.get_proc_address(s) as *const _) };
    // let gl = gl::ErrorReactingGl::wrap(gl, move |_gl, fun, err| {
    //     println!("Error 0x{:x} in {}", err, fun);
    // });
    gl.clear_color(0.0, 0.0, 0.0, 1.0);

    let mut results: HashMap<&'static str, HashMap<&'static str, u128>> = HashMap::default();

    println!("Vendor: {}", gl.get_string(gl::VENDOR));
    println!("Renderer: {}", gl.get_string(gl::RENDERER));
    println!("Version: {}", gl.get_string(gl::VERSION));

    println!("\n");
    println!("Compiling unoptimised shaders");
    for shader in shader_source::UNOPT_SHADERS.iter() {
        if shader.name.contains("_Gles") {
            let res = compile_shader(gl.as_ref(), &shader);
            let row = results.entry(shader.name).or_default();
            row.insert("unopt", res);
        }
    }

    println!("\n");
    println!("Compiling optimised not rebased shaders");
    for shader in shader_source::OPT_NOREBASE_SHADERS.iter() {
        if shader.name.contains("_Gles") {
            let res = compile_shader(gl.as_ref(), &shader);
            let row = results.entry(shader.name).or_default();
            row.insert("glslopt-norebase", res);
        }
    }

    println!("\n");
    println!("Compiling optimised rebased shaders");
    for shader in shader_source::OPT_REBASE_SHADERS.iter() {
        if shader.name.contains("_Gles") {
            let res = compile_shader(gl.as_ref(), &shader);
            let row = results.entry(shader.name).or_default();
            row.insert("glslopt-rebase", res);
        }
    }

    println!("\n");
    println!("Final Results:");
    println!("Shader,Unoptimized,glslopt norebase,glslopt rebase,");
    for (shader_name, results) in &results {
        println!(
            "{},{},{},{},",
            shader_name,
            results.get("unopt").map(|v| (*v as f64 / 1000.0).to_string()).unwrap_or("".to_string()),
            results.get("glslopt-norebase").map(|v| (*v as f64 / 1000.0).to_string()).unwrap_or("".to_string()),
            results.get("glslopt-rebase").map(|v| (*v as f64 / 1000.0).to_string()).unwrap_or("".to_string()),
        );
    }

    event_loop.run_forever(|event| {
        match event {
            Event::WindowEvent { ref event, .. } => match event {
                WindowEvent::Resized(logical_size) => {
                    let dpi_factor = context.window().get_hidpi_factor();
                    context.resize(logical_size.to_physical(dpi_factor));
                }
                WindowEvent::Refresh => {
                    gl.clear(gl::COLOR_BUFFER_BIT);
                    context.swap_buffers().unwrap();
                }
                WindowEvent::CloseRequested => return ControlFlow::Break,
                _ => (),
            },
            _ => (),
        }

        return ControlFlow::Continue;
    })
}
