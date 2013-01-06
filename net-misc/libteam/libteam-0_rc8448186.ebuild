# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/libteam/libteam-0_rc8448186.ebuild,v 1.1 2012/10/22 12:25:33 pinkbyte Exp $

EAPI=4

AUTOTOOLS_AUTORECONF="yes"
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit  autotools-utils linux-info versionator

MY_PV="$(get_version_component_range 2-)"
MY_PV="${MY_PV/rc/}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Library and tools set for controlling team network device"
HOMEPAGE="https://fedorahosted.org/libteam/"
SRC_URI="http://rion-overlay.googlecode.com/files/jpirko-${MY_P}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples +syslog"

DEPEND="dev-libs/jansson
	dev-libs/libdaemon
	dev-libs/libnl:3[utils]
	sys-apps/dbus
	"
RDEPEND="${DEPEND}
	syslog? ( virtual/logger )"

CONFIG_CHECK="~NET_TEAM ~NET_TEAM_MODE_ROUNDROBIN ~NET_TEAM_MODE_ACTIVEBACKUP"
ERROR_NET_TEAM="NET_TEAM is not enabled in this kernel!
Only >=3.3.0 kernel version support in team mode"

S="${WORKDIR}/jpirko-${MY_P}"

DOCS=( HOWTO.BASICS README )

src_prepare() {
	# avoid using -Werror in CFLAGS
	sed -i -e '/^CFLAGS/s/-Werror//' configure.ac || die 'sed on CFLAGS failed'

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
		$(use_enable syslog logging)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	insinto /etc/dbus-1/system.d/
	doins teamd/dbus/teamd.conf

	if use examples; then
		insinto /etc/"${PN}"/example
		doins teamd/example_configs/*
	fi
}
