# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_cthelper/libnetfilter_cthelper-1.0.0.ebuild,v 1.3 2012/12/29 18:40:00 jer Exp $

EAPI=5
inherit linux-info autotools-utils

DESCRIPTION="userspace library that provides the programming interface to the user-space helper infrastructure"
HOMEPAGE="http://www.netfilter.org/projects/libnetfilter_cthelper"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="static-libs"

RDEPEND="net-libs/libmnl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="~NF_CT_NETLINK_HELPER"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 3 6 0 && ewarn "requires at least 3.6.0 kernel version"
}
