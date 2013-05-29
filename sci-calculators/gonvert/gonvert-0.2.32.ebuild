# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/gonvert/gonvert-0.2.32.ebuild,v 1.2 2013/05/29 16:11:41 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-single-r1

DESCRIPTION="Unit conversion utility written in PyGTK"
HOMEPAGE="http://unihedron.com/projects/gonvert/index.php"
SRC_URI="http://unihedron.com/projects/gonvert/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~amd64-linux ~x86-linux"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-python/pygtk:2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/0.2.23-paths.patch )

src_install () {
	emake install DESTDIR="${D}" prefix="${EPREFIX}/usr"
	python_fix_shebang "${ED}"/usr/bin
	rm -fr "${ED}/usr/share/doc/${PN}"
	dodoc doc/{CHANGELOG,FAQ,README,THANKS,TODO}
}
