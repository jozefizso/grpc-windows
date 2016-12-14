set(protoc_files
  ${protobuf_source_dir}/src/google/protobuf/compiler/main.cc
  ${protobuf_source_dir}/src/google/protobuf/compiler/protoc.rc
)

add_executable(protoc ${protoc_files})
target_link_libraries(protoc libprotobuf libprotoc)