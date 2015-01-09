# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipt_netflow/ipt_netflow-2.0.1.ebuild,v 1.3 2015/01/09 20:39:26 pinkbyte Exp $

EAPI=5
inherit eutils linux-info linux-mod multilib toolchain-funcs

DESCRIPTION="Netflow iptables module"
HOMEPAGE="http://sourceforge.net/projects/ipt-netflow"
SRC_URI="mirror://sourceforge/ipt-netflow/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="debug pax_kernel"

RDEPEND="net-firewall/iptables"
DEPEND="${RDEPEND}
	virtual/linux-sources
	virtual/pkgconfig
"

# set S before MODULE_NAMES
S="${WORKDIR}/${PN/_/-}-${PV}"

BUILD_TARGETS="all"
MODULE_NAMES="ipt_NETFLOW(ipt_netflow:${S})"

IPT_LIB="/usr/$(get_libdir)/xtables"

pkg_setup() {
	local CONFIG_CHECK="~IP_NF_IPTABLES"
	use debug && CONFIG_CHECK+=" ~DEBUG_FS"
	kernel_is -gt 3 16 && die "${P} requires kernel version < 3.17"
	linux-mod_pkg_setup
}

src_prepare() {
	sed -i \
		-e 's:make -C:$(MAKE) -C:g' \
		-e 's:gcc -O2:$(CC) $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' \
		Makefile.in || die

	# bug #455984
	epatch "${FILESDIR}/${PN}-2.0-configure.patch"

	# bugs #466430 and #519480
	if use pax_kernel; then
		epatch "${FILESDIR}/${PN}-2.0-pax-const.patch"
	fi

	epatch_user
}

do_conf() {
	echo ./configure $*
	./configure $* || die 'configure failed'
}

src_configure() {
	local IPT_VERSION="$($(tc-getPKG_CONFIG) --modversion xtables)"
	# this configure script is not based on autotools
	# ipt-src need to be defined, see bug #455984
	do_conf \
		--ipt-lib="${IPT_LIB}" \
		--ipt-src="/usr/" \
		--ipt-ver="${IPT_VERSION}" \
		--kdir="${KV_DIR}" \
		--kver="${KV_FULL}" \
		$(use debug && echo '--enable-debugfs')
}

src_compile() {
	emake ARCH="$(tc-arch-kernel)" CC="$(tc-getCC)" all
}

src_install() {
	linux-mod_src_install
	exeinto "${IPT_LIB}"
	doexe libipt_NETFLOW.so
	doheader ipt_NETFLOW.h
	dodoc README*
}
