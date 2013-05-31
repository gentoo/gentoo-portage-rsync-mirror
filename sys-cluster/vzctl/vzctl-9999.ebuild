# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-9999.ebuild,v 1.15 2013/05/31 15:20:52 maksbotan Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit bash-completion-r1 autotools-utils git-2 toolchain-funcs udev

DESCRIPTION="OpenVZ ConTainers control utility"
HOMEPAGE="http://openvz.org/"
EGIT_REPO_URI="git://git.openvz.org/pub/${PN}
	http://git.openvz.org/pub/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ploop vanilla-kernel vz-kernel"

RDEPEND="net-firewall/iptables
		sys-apps/ed
		>=sys-apps/iproute2-3.3.0
		vz-kernel? ( sys-fs/vzquota )
		ploop? ( >=sys-cluster/ploop-1.6 )
		vanilla-kernel? ( >=dev-libs/libcgroup-0.37 )
		"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="^^ ( vz-kernel vanilla-kernel )"

src_prepare() {

	# Set default OSTEMPLATE on gentoo
	sed -i -e 's:=redhat-:=gentoo-:' etc/dists/default || die 'sed on etc/dists/default failed'
	# Set proper udev directory
	sed -i -e "s:/lib/udev:$(udev_get_udevdir):" src/lib/dev.c || die 'sed on src/lib/dev.c failed'

	#provide user_epatch
	autotools-utils_src_prepare
}

src_configure() {

	local myeconfargs=(
		--localstatedir=/var
		--enable-udev
		--enable-bashcomp
		--enable-logrotate
		--with-vz
		$(use_with ploop)
		$(use_with vanilla-kernel cgroup)
		)

	autotools-utils_src_configure
}

src_install() {

	emake DESTDIR="${D}" udevdir="$(udev_get_udevdir)"/rules.d install install-gentoo

	# install the bash-completion script into the right location
	rm -rf "${ED}"/etc/bash_completion.d
	newbashcomp etc/bash_completion.d/vzctl.sh ${PN}

	# We need to keep some dirs
	keepdir /vz/{dump,lock,root,private,template/cache}
	keepdir /etc/vz/names /var/lib/vzctl/veip
}

pkg_postinst() {

	ewarn "To avoid loosing network to CTs on iface down/up, please, add the"
	ewarn "following code to /etc/conf.d/net:"
	ewarn " postup() {"
	ewarn "     /usr/sbin/vzifup-post \${IFACE}"
	ewarn " }"

	ewarn "Starting with 3.0.25 there is new vzeventd service to reboot CTs."
	ewarn "Please, drop /usr/share/vzctl/scripts/vpsnetclean and"
	ewarn "/usr/share/vzctl/scripts/vpsreboot from crontab and use"
	ewarn "/etc/init.d/vzeventd."

	if use vanilla-kernel; then
		einfo "You have selected vanilla' kernel support."
		einfo "If you need checkpoint suspend/restore feature"
		einfo "please install 'sys-process/criu' "
		einfo "This is experimental and not stable (in gentoo) now"
	fi
}
