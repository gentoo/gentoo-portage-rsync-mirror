# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoocanvas/pygoocanvas-0.14.1-r1.ebuild,v 1.5 2013/03/26 16:50:40 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"
PYTHON_COMPAT=(python2_{6,7} )

inherit gnome2 python-r1

DESCRIPTION="GooCanvas python bindings"
HOMEPAGE="http://live.gnome.org/PyGoocanvas"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="examples"

RDEPEND="
	>=dev-python/pygobject-2.11.3:2[${PYTHON_USEDEP}]
	>=dev-python/pygtk-2.10.4:2[${PYTHON_USEDEP}]
	>=dev-python/pycairo-1.8.4[${PYTHON_USEDEP}]
	>=x11-libs/goocanvas-0.14:0
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.4
	virtual/pkgconfig
"

src_prepare() {
	prepare_binding() {
		mkdir -p "${BUILD_DIR}" || die
	}
	python_foreach_impl prepare_binding
}

src_configure() {
	# docs installs gtk-doc and xsltproc is not actually used
	configure_binding() {
		ECONF_SOURCE="${S}" gnome2_src_configure \
			--enable-docs \
			XSLTPROC=$(type -P true)
	}
	python_foreach_impl run_in_build_dir configure_binding
}

src_compile() {
	python_foreach_impl run_in_build_dir gnome2_src_compile
}

src_test() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	python_foreach_impl run_in_build_dir gnome2_src_install

	dodoc AUTHORS ChangeLog* NEWS

	if use examples; then
		rm demo/Makefile* || die
		cp -R demo "${D}"/usr/share/doc/${PF} || die
	fi
}

run_in_build_dir() {
	pushd "${BUILD_DIR}" > /dev/null || die
	"$@"
	popd > /dev/null
}
