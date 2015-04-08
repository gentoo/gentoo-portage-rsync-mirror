# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/pglinux/pglinux-2.2.1_p20120711.ebuild,v 1.5 2015/03/31 12:19:54 kensington Exp $

EAPI=4

inherit gnome2-utils linux-info

MY_P="pgl-${PV}"

DESCRIPTION="Privacy oriented firewall application"
HOMEPAGE="https://sourceforge.net/projects/peerguardian/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${MY_P}.tar.xz"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="cron dbus logrotate networkmanager qt4 zlib"

COMMON_DEPEND="
	net-libs/libnetfilter_queue
	net-libs/libnfnetlink
	dbus? ( sys-apps/dbus )
	zlib? ( sys-libs/zlib )
	qt4? ( sys-auth/polkit-qt[qt4(+)]
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4
		|| ( kde-base/kdesu x11-libs/gksu x11-misc/ktsuss )
	)"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	sys-devel/libtool:2"
RDEPEND="${COMMON_DEPEND}
	net-firewall/iptables
	sys-apps/sysvinit
	cron? ( virtual/cron )
	logrotate? ( app-admin/logrotate )
	networkmanager? ( net-misc/networkmanager )"

REQUIRED_USE="qt4? ( dbus )"

CONFIG_CHECK="~NETFILTER_NETLINK
	~NETFILTER_NETLINK_QUEUE
	~NETFILTER_XTABLES
	~NETFILTER_XT_TARGET_NFQUEUE
	~NETFILTER_XT_MATCH_IPRANGE
	~NETFILTER_XT_MARK
	~NETFILTER_XT_MATCH_MULTIPORT
	~NETFILTER_XT_MATCH_STATE
	~NF_CONNTRACK
	~NF_CONNTRACK_IPV4
	~NF_DEFRAG_IPV4
	~IP_NF_FILTER
	~IP_NF_IPTABLES
	~IP_NF_TARGET_REJECT"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--localstatedir=/var \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable logrotate) \
		$(use_enable cron) \
		$(use_enable networkmanager) \
		$(use_enable zlib) \
		$(use_enable dbus) \
		--disable-lowmem \
		--with-iconsdir=/usr/share/icons/hicolor/128x128/apps \
		--with-gentoo-init \
		$(use_with qt4)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	elog "optional dependencies:"
	elog "  app-arch/p7zip (needed for blocklists packed as .7z)"
	elog "  app-arch/unzip (needed for blocklists packed as .zip)"
	elog "  virtual/mta (needed to send informational (blocklist updates) and"
	elog "    warning mails (if pglcmd.wd detects a problem.))"

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
