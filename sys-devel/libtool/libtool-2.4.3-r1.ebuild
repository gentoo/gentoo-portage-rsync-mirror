# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-2.4.3-r1.ebuild,v 1.6 2014/11/01 02:55:00 vapier Exp $

EAPI="4"

LIBTOOLIZE="true" #225559
WANT_LIBTOOL="none"
inherit eutils autotools multilib unpacker multilib-minimal

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.savannah.gnu.org/${PN}.git
		http://git.savannah.gnu.org/r/${PN}.git"
	inherit git-2
else
	SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/"

LICENSE="GPL-2"
SLOT="2"
IUSE="static-libs test vanilla"

RDEPEND="sys-devel/gnuconfig
	!<sys-devel/autoconf-2.62:2.5
	!<sys-devel/automake-1.11.1:1.11
	!=sys-devel/libtool-2*:1.5
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20140406-r2
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}
	test? ( !<sys-devel/binutils-2.20 )
	app-arch/xz-utils"
[[ ${PV} == "9999" ]] && DEPEND+=" sys-apps/help2man"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
		cd "${S}"
		./bootstrap || die
	else
		unpacker_src_unpack
	fi
}

src_prepare() {
	use vanilla && return 0

	epatch "${FILESDIR}"/${PN}-2.4.3-use-linux-version-in-fbsd.patch #109105
	epatch "${FILESDIR}"/${PN}-2.4.3-no-clean-gnulib.patch #527200
	epatch "${FILESDIR}"/${PN}-2.4.3-test-cmdline_wrap.patch #384731
	pushd libltdl >/dev/null
	AT_NOELIBTOOLIZE=yes eautoreconf
	popd >/dev/null
	AT_NOELIBTOOLIZE=yes eautoreconf
	epunt_cxx
}

multilib_src_configure() {
	# the libtool script uses bash code in it and at configure time, tries
	# to find a bash shell.  if /bin/sh is bash, it uses that.  this can
	# cause problems for people who switch /bin/sh on the fly to other
	# shells, so just force libtool to use /bin/bash all the time.
	export CONFIG_SHELL=/bin/bash
	ECONF_SOURCE="${S}" \
	econf $(use_enable static-libs static)
}

hack_libtool() {
	# Building libtool with --disable-static will cause the installed
	# helper to not build static objects by default.  This is undesirable
	# for crappy packages that utilize the system libtool, so undo that.
	# It also breaks some unittests. #384731
	sed -i -e '1,/^build_old_libs=/{/^build_old_libs=/{s:=.*:=yes:}}' "$@" || die
}

multilib_src_test() {
	hack_libtool libtool
	emake check
}

multilib_src_install_all() {
	dodoc AUTHORS ChangeLog* NEWS README THANKS TODO doc/PLATFORMS

	# While the libltdl.la file is not used directly, the m4 ltdl logic
	# keys off of its existence when searching for ltdl support. #293921
	#use static-libs || find "${ED}" -name libltdl.la -delete

	hack_libtool "${ED}"/usr/bin/libtool

	local x
	for x in $(find "${ED}" -name config.guess -o -name config.sub) ; do
		ln -sf "${EPREFIX}"/usr/share/gnuconfig/${x##*/} "${x}" || die
	done
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libltdl.so.3
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libltdl.so.3
}
