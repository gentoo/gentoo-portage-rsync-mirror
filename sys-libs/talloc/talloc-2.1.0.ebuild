# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/talloc/talloc-2.1.0.ebuild,v 1.3 2014/02/01 20:50:03 vostorga Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="threads"

inherit waf-utils python-single-r1 multilib multilib-minimal

DESCRIPTION="Samba talloc library"
HOMEPAGE="http://talloc.samba.org/"
SRC_URI="http://samba.org/ftp/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~x64-macos ~sparc-solaris"
IUSE="compat +python"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-baselibs-20130224-r5 )
	!!<sys-libs/talloc-2.0.5"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	|| ( dev-lang/python:2.7[threads] dev-lang/python:2.6[threads] )"

WAF_BINARY="${S}/buildtools/bin/waf"

src_prepare() {
	multilib_copy_sources
}

multilib_src_configure() {
	local extra_opts=""

	use compat && extra_opts+=" --enable-talloc-compat1"
	use python || extra_opts+=" --disable-python"
	waf-utils_src_configure \
		${extra_opts}
}

multilib_src_install() {
	waf-utils_src_install

	# waf is stupid, and no, we can't fix the build-system, since it's provided
	# as a brilliant binary blob thats decompressed on the fly
	if [[ ${CHOST} == *-darwin* ]] ; then
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libtalloc.2.dylib \
			"${ED}"/usr/$(get_libdir)/libtalloc.2.0.5.dylib || die
		if use python ; then
			install_name_tool \
				-id "${EPREFIX}"/usr/$(get_libdir)/libpytalloc-util.2.dylib \
				"${ED}"/usr/$(get_libdir)/libpytalloc-util.2.0.5.dylib || die
			install_name_tool \
				-change "${S}/bin/default/libtalloc.dylib" \
					"${EPREFIX}"/usr/$(get_libdir)/libtalloc.2.dylib \
				"${ED}"/usr/$(get_libdir)/libpytalloc-util.2.0.5.dylib || die
			install_name_tool \
				-change "${S}/bin/default/libtalloc.dylib" \
					"${EPREFIX}"/usr/$(get_libdir)/libtalloc.2.dylib \
				"${ED}"$(python_get_sitedir)/talloc.bundle || die
	   fi
	fi
}
