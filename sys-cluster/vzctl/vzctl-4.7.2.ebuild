# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-4.7.2.ebuild,v 1.3 2014/07/30 19:27:43 ssuominen Exp $

EAPI="5"

inherit base bash-completion-r1 eutils toolchain-funcs udev

DESCRIPTION="OpenVZ ConTainers control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc64 -amd64-fbsd -x86-fbsd -sparc-fbsd"
IUSE="+ploop +vz-kernel +vzmigrate"

RDEPEND="net-firewall/iptables
		sys-apps/ed
		>=sys-apps/iproute2-3.3.0
		vz-kernel? ( >=sys-fs/vzquota-3.1 )
		ploop? (
			>=sys-cluster/ploop-1.9
			sys-block/parted
			sys-fs/quota
		)
		>=dev-libs/libcgroup-0.38
		vzmigrate? (
			net-misc/openssh
			net-misc/rsync[xattr,acl]
			app-arch/tar[xattr,acl]
		)
		"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	"

src_prepare() {
	# Set default OSTEMPLATE on gentoo
	sed -i -e 's:=redhat-:=gentoo-:' etc/dists/default || die 'sed on etc/dists/default failed'
	# Set proper udev directory
	sed -i -e "s:/lib/udev:$(get_udevdir):" src/lib/dev.c || die 'sed on src/lib/dev.c failed'
}

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-udev \
		--enable-bashcomp \
		--enable-logrotate \
		--with-vz \
		$(use_with ploop) \
		--with-cgroup
}

src_install() {
	emake DESTDIR="${D}" udevdir="$(get_udevdir)"/rules.d install install-gentoo

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
	ewarn "Please remove /usr/share/vzctl/scripts/vpsnetclean and"
	ewarn "/usr/share/vzctl/scripts/vpsreboot from crontab and use"
	ewarn "/etc/init.d/vzeventd."

	if ! has_version sys-process/criu; then
		einfo "If you want checkpoint suspend/restore feature in vanilla kernel"
		einfo "please install sys-process/criu."
		einfo "This is experimental and not stable (in Gentoo) at the moment."
	fi

	if ! has_version app-arch/xz-utils; then
		einfo "If you work with xz compressed templates, please install app-arch/xz-utils"
	fi
	if ! has_version app-crypt/gnupg; then
		einfo "If you want to check signature of donwloaded template, install app-crypt/gnupg"
	fi
}
