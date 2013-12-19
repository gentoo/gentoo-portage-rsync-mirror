# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipt_netflow/ipt_netflow-1.8-r4.ebuild,v 1.1 2013/12/19 19:16:43 pinkbyte Exp $

EAPI="5"

inherit eutils linux-info linux-mod multilib toolchain-funcs

DESCRIPTION="Netflow iptables module"
HOMEPAGE="http://sourceforge.net/projects/ipt-netflow"
SRC_URI="mirror://sourceforge/ipt-netflow/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="pax_kernel"

RDEPEND="net-firewall/iptables"
DEPEND="${RDEPEND}
	virtual/linux-sources
	virtual/pkgconfig"

BUILD_TARGETS="all"
CONFIG_CHECK="~IP_NF_IPTABLES"
MODULE_NAMES="ipt_NETFLOW(ipt_netflow:${S})"

IPT_LIB="/usr/$(get_libdir)/xtables"

src_prepare() {
	sed -i -e 's:-I$(KDIR)/include::' \
		-e 's:gcc -O2:$(CC) $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' Makefile.in || die 'sed on Makefile.in failed'
	sed -i -e '/IPT_NETFLOW_VERSION/s/1.7.2/1.8/' ipt_NETFLOW.c || die 'sed on ipt_NETFLOW.c failed'

	# bug #455984
	epatch "${FILESDIR}"/${PN}-1.8-configure.patch

	# compatibility with 3.10 kernel
	epatch "${FILESDIR}"/${PN}-1.8-procfs-fix.patch

	# compatibility with 3.11 kernel
	epatch "${FILESDIR}"/${PN}-1.8-numphyspages-fix.patch

	# bug #466430
	if use pax_kernel; then
		epatch "${FILESDIR}"/${PN}-1.8-pax-const.patch
	fi

	epatch_user
}

src_configure() {
	local IPT_VERSION="$($(tc-getPKG_CONFIG) --modversion xtables)"
	# econf can not be used, cause configure script fails when see unknown parameter
	# ipt-src need to be defined, see bug #455984
	./configure \
		--ipt-lib="${IPT_LIB}" \
		--ipt-src="/usr/" \
		--ipt-ver="${IPT_VERSION}" \
		--kdir="${KV_DIR}" \
		--kver="${KV_FULL}" \
	|| die 'configure failed'
}

src_compile() {
	local ARCH="$(tc-arch-kernel)"
	emake CC="$(tc-getCC)" all
}

src_install() {
	linux-mod_src_install
	exeinto "${IPT_LIB}"
	doexe libipt_NETFLOW.so
	doheader ipt_NETFLOW.h
	dodoc README*
}
