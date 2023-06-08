# vimball2

A rewrite of the vimball extractor by [Dr Chip](https://www.drchip.org/) for the vim8 era


## Architecture

This plugin is split in two independent parts:
 - the archiver
 - the extractor

All the features are exposed through the original ex API but
also through new commands and new functions. In fact, the commands are basically
frontends for the API functions, which in turn leverage the plugin's core.


## Usage

You can refer to the documentation, this is just a quick summary.

 - Ex commands:
    * `:VimballArchive directory filename.vba`: Create an archive of directory
    named filename.vba
    * `:VimballExtract`: Extract the opened archive into
        &rtp[1]/pack/vimball/start/
    * `:VimballExtract directory`: Extract the opened archive into directory
    * `:VimballList`: List the content of the opened archive
 - Functions:
    * `vimball2#archive(directory, filename, overwrite?)`: Archive the
        directory directory into the file filename. If the file exists,
        overwrite if overwrite and ask if &confirm
    * `vimball2#extract(bufnr, overwrite?, dest_dir?)`: Extract the archive
        opened in bufnr into dest_dir. If  dest_dir is not specified, it defaults to
        &rtp[1]/pack/vimball/start/$archive
    * `vimball2#list(bufnr)`: List the content of the archive opened in
        bufnr
 - Low level functions
    * `vimball2#archiver#archive(directory, dest_file)` always archive,
        regardless of the dest_file's already existing.
    * `vimball2#extractor#extract(bufnr, dest_dir)`: Always extract the
        archive opened in bufnr into dest_dir, regadless of the dest_dir's
        already existing.


## Why?

Well, mostly for fun.

Actually, I made vimball2 because I stumbled upon Dr Chip's
[website](www.drchip.org) where he distributes his plugins as vimballs.

If you don't know them, they are the author of NetRW, the Zip plugin and
the Tar plugin for vim. They made all that stuff with *vim 7*. Without all the
shiny brand new features of vim 8, such as packages!

And that's exactly what vimballs were made for. With vim 7, packages weren't
a thing. I guess one could have manually added the paths to the
`runtimepath`, or use a plugin such as pathogen, that was made exactly for
this use case.

So vimballs had two purposes: they were a mean to distribute vim packages as
one file (that could even be gzipped) and a way to install and manage them.

But why manage them? Because the vimball extractor extracted files into your
~/.vim directory, putting them in the plugins, ftplugins, etc, along with
other files. No separation!

That's precisely why I made vimball2. vimball2 is made for vim 8 and neovim
so it extracts vimballs into a plugin directory (~/.vim/pack/vimball/start/*).

To achieve this, I had two options:

1) Patch the original vimball plugin's files to hack in vim 8 support
2) Make a brand new plugin

You may think that I went for the latter, but I actually started with the first
option. It was just because of unreliability of this solution that I
wrote an entire plugin for it.
