# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.8.18.ebuild,v 1.3 2012/02/22 00:59:51 patrick Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit eutils distutils libtool toolchain-funcs

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="nls python"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools )"

S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="cracklib.py"
do_python() {
	pushd python > /dev/null || die
	distutils_src_${EBUILD_PHASE}
	popd > /dev/null
}

pkg_setup() {
	# workaround #195017
	if has unmerge-orphans ${FEATURES} && has_version "<${CATEGORY}/${PN}-2.8.10" ; then
		eerror "Upgrade path is broken with FEATURES=unmerge-orphans"
		eerror "Please run: FEATURES=-unmerge-orphans emerge cracklib"
		die "Please run: FEATURES=-unmerge-orphans emerge cracklib"
	fi

	use python && python_pkg_setup
}

src_prepare() {
	elibtoolize #269003
	use python && do_python
}

src_configure() {
	econf \
		--with-default-dict='$(libdir)/cracklib_dict' \
		--without-python \
		$(use_enable nls)
}

src_compile() {
	default
	use python && do_python
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -r "${ED}"/usr/share/cracklib

	use python && do_python

	# move shared libs to /
	gen_usr_ldscript -a crack

	insinto /usr/share/dict
	doins dicts/cracklib-small || die "word dict"

	dodoc AUTHORS ChangeLog NEWS README*
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict /usr/share/dict/* > /dev/null
		eend $?
	fi

	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
