# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moosic/moosic-1.5.6.ebuild,v 1.1 2012/02/19 14:39:24 aballier Exp $

EAPI="3"

inherit bash-completion distutils

DESCRIPTION="Moosic is a music player that focuses on easy playlist management"
HOMEPAGE="http://www.nanoo.org/~daniel/moosic"
SRC_URI="http://www.nanoo.org/~daniel/${PN}/${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="dev-python/setuptools"

src_prepare() {
	distutils_src_prepare
	sed -i -e 's:distutils.core:setuptools:' setup.py || die "sed failed"
}

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
	dobashcompletion examples/completion ${PN}
	dodoc doc/{Moosic_API.txt,moosic_hackers.txt,Todo}
	dodoc examples/server_config
	use doc && dohtml doc/*.html
}

pkg_postinst() {
	bash-completion_pkg_postinst
	distutils_pkg_postinst
}
