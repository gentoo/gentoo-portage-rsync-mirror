# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netctl/netctl-1.1-r1.ebuild,v 1.6 2013/08/02 16:26:09 floppym Exp $

EAPI=5

inherit bash-completion-r1

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://projects.archlinux.org/netctl.git"
	inherit git-2
	DEPEND="app-text/asciidoc"
else
	SRC_URI="ftp://ftp.archlinux.org/other/packages/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Profile based network connection tool from Arch Linux"
HOMEPAGE="https://wiki.archlinux.org/index.php/Netctl
	https://www.archlinux.org/packages/core/any/netctl/
	https://projects.archlinux.org/netctl.git/"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND+="
	virtual/pkgconfig
	sys-apps/systemd
"
RDEPEND="
	>=app-shells/bash-4.0
	>=net-dns/openresolv-3.5.4-r1
	sys-apps/iproute2
	sys-apps/systemd
	!<net-misc/dhcpcd-5.6.7
"

src_prepare() {
	sed -i -e "s:/usr/bin/ifplugd:/usr/sbin/ifplugd:" \
		"services/netctl-ifplugd@.service" || die
}

src_compile() {
	return 0
}

src_install() {
	emake DESTDIR="${D%/}" SHELL=bash install
	dodoc AUTHORS NEWS README
	newbashcomp contrib/bash-completion netctl
	insinto /usr/share/zsh/site-functions
	newins contrib/zsh-completion _netctl
}

optfeature() {
	local desc=$1
	shift
	while (( $# )); do
		if has_version "$1"; then
			elog "  [I] $1 for ${desc}"
		else
			elog "  [ ] $1 for ${desc}"
		fi
		shift
	done
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "To get additional features, a number of option runtime dependencies may be"
		elog "installed."
		optfeature "DHCP support" net-misc/dhcpcd ">=net-misc/dhcp-5.6.7[client]"
		optfeature "WPA support" net-wireless/wpa_supplicant
		optfeature "interactive assistant" dev-util/dialog
		optfeature "automatic connection" sys-apps/ifplugd
		optfeature "bonding support" net-misc/ifenslave
		optfeature "bridge support" net-misc/bridge-utils
		optfeature "dialup support" net-dialup/ppp
	fi
}
