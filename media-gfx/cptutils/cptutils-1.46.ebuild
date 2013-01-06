# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cptutils/cptutils-1.46.ebuild,v 1.1 2012/12/15 03:08:00 radhermit Exp $

EAPI=5

inherit python

DESCRIPTION="A number of utilities for the manipulation of color gradient files"
HOMEPAGE="http://soliton.vm.bytemark.co.uk/pub/jjg/en/code/cptutils.html"
SRC_URI="http://soliton.vm.bytemark.co.uk/pub/jjg/code/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-libs/libxml2:2
	media-libs/libpng"
RDEPEND="${CDEPEND}
	=dev-lang/python-2*"
DEPEND="${CDEPEND}"

src_prepare() {
	python_convert_shebangs 2 src/gradient-convert/gradient-convert.py
}
