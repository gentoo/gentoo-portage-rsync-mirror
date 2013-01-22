# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythong/pythong-2.1.5-r1.ebuild,v 1.7 2013/01/22 19:06:03 jlec Exp $

EAPI="3"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit python

MY_PN="pythonG"
MY_PV=${PV/_/-}
MY_PV=${MY_PV//\./_}

DESCRIPTION="Nice and powerful spanish development environment for Python"
SRC_URI="http://www3.uji.es/~dllorens/downloads/pythong/linux/${MY_PN}-${MY_PV}.tgz
	doc? ( http://marmota.act.uji.es/MTP/pdf/python.pdf )"
HOMEPAGE="http://www3.uji.es/~dllorens/PythonG/principal.html"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 x86"
SLOT="0"
IUSE="doc"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

RDEPEND=">=dev-lang/tk-8.3.4
	>=dev-python/pmw-1.2:0"
DEPEND="${RDEPEND}"

src_prepare() {
	python_copy_sources

	preparation() {
		sed -i \
			-e "s:^\(fullpath = \).*:\1'$(python_get_sitedir)':" \
			-e "/^url_docFuncPG/s:'+fullpath+':/usr/share/doc/${PF}:" \
			pythong.py || die "sed in pythong.py failed"
	}
	python_execute_function -s preparation
}

src_install() {
	installation() {
		insinto $(python_get_sitedir)
		doins modulepythong.py || die "doins failed"
		doins -r libpythong || die "doins failed"

		exeinto /usr/bin
		newexe pythong.py pythong.py-${PYTHON_ABI} || die "doexe failed"
		python_convert_shebangs $(python_get_version) "${ED}usr/bin/pythong.py-${PYTHON_ABI}"
	}
	python_execute_function -s installation

	python_generate_wrapper_scripts "${ED}usr/bin/pythong.py"

	dodoc leeme.txt || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	doins -r {LICENCIA,MANUAL,demos} || die "doins failed"
	rm -fr "${ED}/usr/share/doc/${PF}/demos/modulepythong.py"

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}/python.pdf"
	fi
}

pkg_postinst() {
	python_mod_optimize libpythong
}

pkg_postrm() {
	python_mod_cleanup libpythong
}
