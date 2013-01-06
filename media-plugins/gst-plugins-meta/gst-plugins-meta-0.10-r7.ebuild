# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-meta/gst-plugins-meta-0.10-r7.ebuild,v 1.16 2012/12/09 08:58:08 tetromino Exp $

EAPI="4"

DESCRIPTION="Meta ebuild to pull in gst plugins for apps"
HOMEPAGE="http://www.gentoo.org"

LICENSE="metapackage"
SLOT="0.10"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x86-solaris"
IUSE="aac a52 alsa dts dv dvb dvd ffmpeg flac http lame libvisual mms mp3 mpeg musepack ogg oss pulseaudio taglib theora v4l vcd vorbis vpx wavpack X xv"

RDEPEND="media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	media-libs/gst-plugins-good:0.10
	a52? ( media-plugins/gst-plugins-a52dec:0.10 )
	aac? ( media-plugins/gst-plugins-faad:0.10 )
	alsa? ( media-plugins/gst-plugins-alsa:0.10 )
	dts? ( media-plugins/gst-plugins-dts:0.10 )
	dv? ( media-plugins/gst-plugins-dv:0.10 )
	dvb? (
		media-plugins/gst-plugins-dvb:0.10
		>=media-libs/gst-plugins-bad-0.10.6:0.10 )
	dvd? (
		media-libs/gst-plugins-ugly:0.10
		media-plugins/gst-plugins-a52dec:0.10
		media-plugins/gst-plugins-dvdread:0.10
		media-plugins/gst-plugins-mpeg2dec:0.10
		>=media-plugins/gst-plugins-resindvd-0.10.14:0.10 )
	ffmpeg? ( media-plugins/gst-plugins-ffmpeg:0.10 )
	flac? ( media-plugins/gst-plugins-flac:0.10 )
	http? ( media-plugins/gst-plugins-soup:0.10 )
	lame? ( media-plugins/gst-plugins-lame:0.10 )
	libvisual? ( media-plugins/gst-plugins-libvisual:0.10 )
	mms? ( media-plugins/gst-plugins-libmms:0.10 )
	mp3? ( media-libs/gst-plugins-ugly:0.10
		media-plugins/gst-plugins-mad:0.10 )
	mpeg? ( media-plugins/gst-plugins-mpeg2dec:0.10 )
	musepack? ( media-plugins/gst-plugins-musepack:0.10 )
	ogg? ( media-plugins/gst-plugins-ogg:0.10 )
	oss? ( media-plugins/gst-plugins-oss:0.10 )
	pulseaudio? ( media-plugins/gst-plugins-pulse:0.10 )
	theora? (
		media-plugins/gst-plugins-ogg:0.10
		media-plugins/gst-plugins-theora:0.10 )
	taglib? ( media-plugins/gst-plugins-taglib:0.10 )
	v4l? ( media-plugins/gst-plugins-v4l2:0.10 )
	vcd? (	media-plugins/gst-plugins-mplex:0.10
		media-plugins/gst-plugins-mpeg2dec:0.10 )
	vorbis? (
		media-plugins/gst-plugins-ogg:0.10
		media-plugins/gst-plugins-vorbis:0.10 )
	vpx? ( media-plugins/gst-plugins-vp8:0.10 )
	wavpack? ( media-plugins/gst-plugins-wavpack:0.10 )
	X? ( media-plugins/gst-plugins-x:0.10 )
	xv? ( media-plugins/gst-plugins-xvideo:0.10 )"

# Usage note:
# The idea is that apps depend on this for optional gstreamer plugins.  Then,
# when USE flags change, no app gets rebuilt, and all apps that can make use of
# the new plugin automatically do.

# When adding deps here, make sure the keywords on the gst-plugin are valid.
