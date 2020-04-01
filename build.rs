use std::{
    env,
    io::Write,
    fs::{canonicalize, File, read_dir},
    path::{Path, PathBuf},
};

fn write_shaders(shader_file: &mut File, name: &str, shaders: Vec<PathBuf>) {


    write!(shader_file, "    pub static ref {}: Vec<Shader> = {{\n", name).unwrap();
    write!(shader_file, "        let mut shaders = Vec::new();\n").unwrap();
    for shader in shaders {
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
}

fn main() {
    let mut unopt_shaders = Vec::new();
    let unopt_shaders_dir = Path::new("res/unopt_shaders");
    for entry in read_dir(unopt_shaders_dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if entry.file_name().to_str().unwrap().ends_with(".vert") {
            unopt_shaders.push(path.to_owned());
        }
    }
    unopt_shaders.sort_by(|a, b| a.file_name().cmp(&b.file_name()));

    let mut opt_norebase_shaders = Vec::new();
    let opt_norebase_shaders_dir = Path::new("res/opt_norebase_shaders");
    for entry in read_dir(opt_norebase_shaders_dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if entry.file_name().to_str().unwrap().ends_with(".vert") {
            opt_norebase_shaders.push(path.to_owned());
        }
    }
    opt_norebase_shaders.sort_by(|a, b| a.file_name().cmp(&b.file_name()));

    let mut opt_rebase_shaders = Vec::new();
    let opt_rebase_shaders_dir = Path::new("res/opt_rebase_shaders");
    for entry in read_dir(opt_rebase_shaders_dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if entry.file_name().to_str().unwrap().ends_with(".vert") {
            opt_rebase_shaders.push(path.to_owned());
        }
    }
    opt_rebase_shaders.sort_by(|a, b| a.file_name().cmp(&b.file_name()));

    let out_dir = env::var_os("OUT_DIR").unwrap();
    let shader_file_path = Path::new(&out_dir).join("shaders.rs");
    let mut shader_file = File::create(shader_file_path).unwrap();

    write!(shader_file, "pub struct Shader {{ pub name: &'static str, pub vert: &'static str, pub frag: &'static str }}\n\n").unwrap();
    write!(shader_file, "lazy_static! {{\n").unwrap();
    write_shaders(&mut shader_file, "UNOPT_SHADERS", unopt_shaders);
    write_shaders(&mut shader_file, "OPT_NOREBASE_SHADERS", opt_norebase_shaders);
    write_shaders(&mut shader_file, "OPT_REBASE_SHADERS", opt_rebase_shaders);
    write!(shader_file, "}}\n").unwrap();
}
