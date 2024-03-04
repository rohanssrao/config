set -q color_vi_mode_normal; or set color_vi_mode_normal green
set -q color_vi_mode_insert; or set color_vi_mode_insert blue 
set -q color_vi_mode_visual; or set color_vi_mode_visual red

function fish_mode_prompt
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set color_distro_str $color_vi_mode_normal
      case insert
        set color_distro_str $color_vi_mode_insert
      case visual
        set color_distro_str $color_vi_mode_visual
    end
  end
end
