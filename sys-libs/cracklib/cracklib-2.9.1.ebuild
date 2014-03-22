# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.9.1.ebuild,v 1.7 2014/03/22 20:38:24 nimiux Exp $

EAPI="4"
PYTHON_COMPAT=( python{2_6,2_7} )
DISTUTILS_OPTIONAL=1

inherit eutils distutils-r1 libtool toolchain-funcs

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~m68k-mint"
IUSE="nls python static-libs test zlib"

RDEPEND="zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	python? (
		dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/nose[${PYTHON_USEDEP}] )
	)"

S=${WORKDIR}/${MY_P}

do_python() {
	use python || return 0
	pushd python > /dev/null || die
	distutils-r1_src_${EBUILD_PHASE}
	popd > /dev/null
}

pkg_setup() {
	# workaround #195017
	if has unmerge-orphans ${FEATURES} && has_version "<${CATEGORY}/${PN}-2.8.10" ; then
		eerror "Upgrade path is broken with FEATURES=unmerge-orphans"
		eerror "Please run: FEATURES=-unmerge-orphans emerge cracklib"
		die "Please run: FEATURES=-unmerge-orphans emerge cracklib"
	fi
}

src_prepare() {
	elibtoolize #269003
	do_python
}

src_configure() {
	export ac_cv_header_zlib_h=$(usex zlib)
	export ac_cv_search_gzopen=$(usex zlib -lz no)
	econf \
		--with-default-dict='$(libdir)/cracklib_dict' \
		--without-python \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_compile() {
	default
	do_python
}

src_test() {
	do_python
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

src_install() {
	default
	use static-libs || find "${ED}"/usr -name libcrack.la -delete
	rm -r "${ED}"/usr/share/cracklib

	do_python

	# move shared libs to /
	gen_usr_ldscript -a crack

	insinto /usr/share/dict
	doins dicts/cracklib-small || die
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict "${EPREFIX}"/usr/share/dict/* > /dev/null
		eend $?
	fi
}
