# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-2.0.0.ebuild,v 1.1 2013/03/11 20:14:14 ssuominen Exp $

EAPI=5
inherit autotools eutils #libtool

DESCRIPTION="ILM's OpenEXR high dynamic-range image file format libraries"
HOMEPAGE="http://openexr.com/"
SRC_URI="http://download.savannah.gnu.org/releases/openexr/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 -arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="examples static-libs"

RDEPEND="sys-libs/zlib
	>=media-libs/ilmbase-${PV}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${P}/OpenEXR

src_prepare() {
	sed -i -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die
	# Fix path for testsuite
	sed -i -e "s:/var/tmp/:${T}:" IlmImfTest/tmpDir.h || die
	# Required for function memset()
	sed -i -e '1i#include <string.h>' IlmImf/ImfAutoArray.h || die

	eautoreconf
#	elibtoolize
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
