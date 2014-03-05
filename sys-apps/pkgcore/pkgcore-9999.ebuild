# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-9999.ebuild,v 1.14 2014/03/05 10:36:23 mgorny Exp $

EAPI=4
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://code.google.com/p/pkgcore/"
	EGIT_MIN_CLONE_TYPE=single
	inherit git-r3
else
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
	SRC_URI="http://pkgcore.googlecode.com/files/${P}.tar.bz2"
fi

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://pkgcore.googlecode.com/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+doc"

RDEPEND="=dev-python/snakeoil-9999[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"

pkg_setup() {
	# disable snakeoil 2to3 caching...
	unset PY2TO3_CACHEDIR

	mydistutilsargs=(
		build
		--disable-html-docs
		--disable-man-pages
	)
}

python_compile_all() {
	esetup.py build_man $(use doc && echo 'build_docs')

	# symlinks generated manpages into source root
	# dead symlinks are tolerated
	ln -s "${BUILD_DIR}/sphinx/man" man || die
	ln -s "${BUILD_DIR}/sphinx/html" html || die
}

python_test() {
	esetup.py test
}

src_install() {
	mydistutilsargs+=(
		install
		--disable-html-docs
		--disable-man-pages
	)

	distutils-r1_src_install
}

python_install_all() {
	local cmds=(
		install_man
	)
	use doc && cmds+=(
		install_docs --path="${ED%/}"/usr/share/doc/${PF}/html
	)

	distutils-r1_python_install "${cmds[@]}"
	distutils-r1_python_install_all
}

pkg_postinst() {
	pplugincache
}
