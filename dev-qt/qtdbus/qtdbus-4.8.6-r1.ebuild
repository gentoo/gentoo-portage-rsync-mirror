# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtdbus/qtdbus-4.8.6-r1.ebuild,v 1.1 2014/11/15 02:36:03 pesa Exp $

EAPI=5

inherit qt4-build-multilib

DESCRIPTION="The DBus module for the Qt toolkit"

if [[ ${QT4_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}[aqua=,debug=,${MULTILIB_USEDEP}]
	sys-apps/dbus[${MULTILIB_USEDEP}]
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.7-qdbusintegrator-no-const.patch"
	"${FILESDIR}/${PN}-4.8.4-qdbusconnection-silence-warning.patch"
)

QT4_TARGET_DIRECTORIES="
	src/dbus
	tools/qdbus/qdbus
	tools/qdbus/qdbusxml2cpp
	tools/qdbus/qdbuscpp2xml"

QCONFIG_ADD="dbus dbus-linked"
QCONFIG_DEFINE="QT_DBUS"

multilib_src_configure() {
	local myconf=(
		-dbus-linked
	)
	qt4_multilib_src_configure
}
