# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.216_pre2910.ebuild,v 1.4 2011/11/20 09:13:21 xarthisius Exp $

inherit eutils bash-completion

MY_P=${P/_/-}
S="${WORKDIR}"/${MY_P}

DESCRIPTION="Linux-VServer admin utilities"
HOMEPAGE="http://www.nongnu.org/util-vserver/"
SRC_URI="http://people.linux-vserver.org/~dhozac/t/uv-testing/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~sparc x86"

IUSE=""

CDEPEND="dev-libs/beecrypt
	net-firewall/iptables
	net-misc/vconfig
	sys-apps/iproute2
	|| ( >=sys-apps/coreutils-6.10-r1 sys-apps/mktemp )"

DEPEND=">=dev-libs/dietlibc-0.30-r2
	${CDEPEND}"

RDEPEND="${CDEPEND}"

pkg_setup() {
	if [[ -z "${VDIRBASE}" ]]; then
		einfo
		einfo "You can change the default vserver base directory (/vservers)"
		einfo "by setting the VDIRBASE environment variable."
	fi

	: ${VDIRBASE:=/vservers}

	einfo
	einfo "Using \"${VDIRBASE}\" as vserver base directory"
	einfo
}

src_compile() {
	econf --with-vrootdir=${VDIRBASE} \
		--with-initscripts=gentoo \
		--localstatedir=/var || die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	make DESTDIR="${D}" install install-distribution \
		|| die "make install failed!"

	# keep dirs
	keepdir /var/run/vservers
	keepdir /var/run/vservers.rev
	keepdir /var/run/vshelper
	keepdir /var/lock/vservers
	keepdir /var/cache/vservers
	keepdir "${VDIRBASE}"
	keepdir "${VDIRBASE}"/.pkg

	# remove legacy config file
	rm -f "${D}"/etc/vservers.conf

	# bash-completion
	dobashcompletion "${FILESDIR}"/bash_completion util-vserver

	dodoc README ChangeLog NEWS AUTHORS THANKS util-vserver.spec
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.30.211"
	old_init_script_warn=$?
}

pkg_postinst() {
	# Create VDIRBASE in postinst, so it is (a) not unmerged and (b) also
	# present when merging.

	[ ! -d "${VDIRBASE}" ] && mkdir -p "${VDIRBASE}" &> /dev/null
	setattr --barrier "${VDIRBASE}" &> /dev/null

	rm /etc/vservers/.defaults/vdirbase
	ln -sf "${VDIRBASE}" /etc/vservers/.defaults/vdirbase

	elog
	elog "You have to run the vprocunhide command after every reboot"
	elog "in order to setup /proc permissions correctly for vserver"
	elog "use. An init script has been installed by this package."
	elog "To use it you should add it to a runlevel:"
	elog
	elog " rc-update add vprocunhide default"
	elog

	if [[ $old_init_script_warn = 0 ]] ; then
		ewarn "Please make sure, that you remove the old init-script from any"
		ewarn "runlevel and remove it from your init.d dir!"
		ewarn
		ewarn "# rc-update del vservers"
		ewarn "# rm -f ${ROOT}etc/init.d/vservers"
		ewarn
		ewarn "Since util-vserver-0.30.211 all Gentoo specific wrappers"
		ewarn "have been merged upstream, and may now have a slightly"
		ewarn "different syntax, i.e. you have to update scripts that"
		ewarn "depend on these wrappers (vesync, vemerge, vupdateworld"
		ewarn "and vdispatch-conf)"
		ewarn
		ewarn "Additionally the init scripts have changed and now use"
		ewarn "upstream scripts as backend. An init script to start"
		ewarn "virtual servers in the 'default' group/mark has been"
		ewarn "installed by this ebuild:"
		ewarn
		ewarn "  rc-update add vservers.default default"
		ewarn
		ewarn "To start vservers in other groups/marks, you have to"
		ewarn "symlink the default init script the same way you do"
		ewarn "with net.* scripts:"
		ewarn
		ewarn "  ln -s /etc/init.d/vservers.default /etc/init.d/vservers.<mark>"
		ewarn
	fi
}
