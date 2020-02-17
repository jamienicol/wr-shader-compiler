use std::{
    env,
    io::Write,
    fs::{canonicalize, File, read_dir},
    path::{Path, PathBuf},
};

fn write_shader_file(shader_file_path: &Path, orig_shaders: Vec<PathBuf>, opt_shaders: Vec<PathBuf>) {
    let mut shader_file = File::create(shader_file_path).unwrap();

    write!(shader_file, "pub struct Shader {{ pub name: &'static str, pub vert: &'static str, pub frag: &'static str }}\n\n").unwrap();
    write!(shader_file, "lazy_static! {{\n").unwrap();

    write!(shader_file, "    pub static ref ORIG_SHADERS: Vec<Shader> = {{\n").unwrap();
    write!(shader_file, "        let mut shaders = Vec::new();\n").unwrap();
    for shader in orig_shaders {
        let name = shader.file_stem().unwrap().to_str().unwrap();
        let vert_path = canonicalize(&shader).unwrap().as_os_str().to_str().unwrap().to_string();
        let frag_path = canonicalize(&shader.with_extension("frag")).unwrap().as_os_str().to_str().unwrap().to_string();
        write!(
            shader_file,
            "        shaders.push(Shader{{ name: \"{}\", vert: include_str!(\"{}\"), frag: include_str!(\"{}\")}});\n",
            name,
            vert_path,
            frag_path
        ).unwrap();
    }
    write!(shader_file, "        shaders\n").unwrap();
    write!(shader_file, "    }};\n").unwrap();

    write!(shader_file, "    pub static ref OPT_SHADERS: Vec<Shader> = {{\n").unwrap();
    write!(shader_file, "        let mut shaders = Vec::new();\n").unwrap();
    for shader in opt_shaders {
        let name = shader.file_stem().unwrap().to_str().unwrap();
        let vert_path = canonicalize(&shader).unwrap().as_os_str().to_str().unwrap().to_string();
        let frag_path = canonicalize(&shader.with_extension("frag")).unwrap().as_os_str().to_str().unwrap().to_string();
        write!(
            shader_file,
            "        shaders.push(Shader{{ name: \"{}\", vert: include_str!(\"{}\"), frag: include_str!(\"{}\")}});\n",
            name,
            vert_path,
            frag_path
        ).unwrap();
    }
    write!(shader_file, "        shaders\n").unwrap();
    write!(shader_file, "    }};\n").unwrap();
    write!(shader_file, "}}\n").unwrap();
}

fn main() {
    let out_dir = env::var_os("OUT_DIR").unwrap();

    let shader_file_path = Path::new(&out_dir).join("shaders.rs");

    let mut orig_shaders = Vec::new();
    let orig_shaders_dir = Path::new("res/orig_shaders");
    for entry in read_dir(orig_shaders_dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if entry.file_name().to_str().unwrap().ends_with(".vert") {
            orig_shaders.push(path.to_owned());
        }
    }
    orig_shaders.sort_by(|a, b| a.file_name().cmp(&b.file_name()));

    let mut opt_shaders = Vec::new();
    let orig_shaders_dir = Path::new("res/opt_shaders");
    for entry in read_dir(orig_shaders_dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if entry.file_name().to_str().unwrap().ends_with(".vert") {
            opt_shaders.push(path.to_owned());
        }
    }
    opt_shaders.sort_by(|a, b| a.file_name().cmp(&b.file_name()));

    write_shader_file(&shader_file_path, orig_shaders, opt_shaders);
}
