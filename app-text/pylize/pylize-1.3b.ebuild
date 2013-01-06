# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pylize/pylize-1.3b.ebuild,v 1.4 2010/03/29 20:50:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Python HTML Slideshow Generator using HTML and CSS"
HOMEPAGE="http://www.chrisarndt.de/en/software/pylize/"
SRC_URI="http://www.chrisarndt.de/en/software/pylize/download/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

DEPEND="dev-python/empy
	dev-python/imaging"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_compile() {
	:
}

src_install() {
	"$(PYTHON)" install.py "${ED}usr" || die "Installation failed"

	# Fix paths in pylize.
	sed \
		-e "s:^sys_libdir.*:sys_libdir = \'/usr/share/pylize\':" \
		-e "s:sys.path.insert(0, sys_libdir):sys.path.remove('/usr/bin'):" \
		-e "s:from roman import dec2roman:from pylize_roman import dec2roman:" \
		-i "${ED}usr/bin/pylize" || die "sed failed"

	# Rename roman.py to pylize_roman.py to avoid collision.
	rm -f "${ED}usr/share/pylize/roman.py"
	insinto $(python_get_sitedir)
	newins lib/roman.py pylize_roman.py

	dodoc Changelog README README.empy TODO
}

pkg_postinst() {
	python_mod_optimize pylize_roman.py
}

pkg_postrm() {
	python_mod_cleanup pylize_roman.py
}
