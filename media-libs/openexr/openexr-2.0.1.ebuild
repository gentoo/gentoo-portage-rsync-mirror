# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-2.0.1.ebuild,v 1.2 2013/07/23 16:55:07 ssuominen Exp $

EAPI=5
inherit eutils libtool

DESCRIPTION="ILM's OpenEXR high dynamic-range image file format libraries"
HOMEPAGE="http://openexr.com/"
SRC_URI="http://download.savannah.gnu.org/releases/openexr/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/2.0.1" # 2.0.1 for the namespace off -> on switch, caused library renaming
KEYWORDS="~alpha ~amd64 -arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="examples static-libs"

RDEPEND="sys-libs/zlib:=
	>=media-libs/ilmbase-${PV}:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# Fix path for testsuite
	sed -i -e "s:/var/tmp/:${T}:" IlmImfTest/tmpDir.h || die
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable examples imfexamples)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF}/pdf \
		examplesdir=/usr/share/doc/${PF}/examples \
		install

	dodoc AUTHORS ChangeLog NEWS README

	if use examples; then
		dobin IlmImfExamples/imfexamples
	else
		rm -rf "${ED}"/usr/share/doc/${PF}/examples
	fi

	prune_libtool_files
}
