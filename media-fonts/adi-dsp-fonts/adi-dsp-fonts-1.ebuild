# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/adi-dsp-fonts/adi-dsp-fonts-1.ebuild,v 1.12 2011/02/06 21:21:16 leio Exp $

inherit font

DESCRIPTION="Analog Devices DSP Fonts"
HOMEPAGE="http://www.analog.com/"
SRC_URI="mirror://gentoo/dsp_logos_font.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

FONT_S="${WORKDIR}"

FONT_SUFFIX="TTF PFB"

DOCS="logo_font_map.pdf trademark_usage.pdf"

DEPEND="app-arch/unzip"
RDEPEND=""
