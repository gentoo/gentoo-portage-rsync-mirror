# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ffmpegthumbs/ffmpegthumbs-4.14.3.ebuild,v 1.6 2015/03/22 13:17:54 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A FFmpeg based thumbnail Generator for Video Files"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug libav"

DEPEND="
	libav? ( media-video/libav:0= )
	!libav? ( media-video/ffmpeg:0= )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdebase-kioslaves)
"
