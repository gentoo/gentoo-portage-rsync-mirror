# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/clsync/clsync-0.4-r1.ebuild,v 1.1 2015/02/20 18:36:49 bircoph Exp $

EAPI=5

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xaionaro/${PN}.git"
else
	SRC_URI="https://github.com/xaionaro/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit autotools eutils linux-info

DESCRIPTION="Live sync tool based on inotify, written in GNU C"
HOMEPAGE="https://github.com/xaionaro/clsync http://ut.mephi.ru/oss/clsync"
LICENSE="GPL-3+"
SLOT="0"
IUSE="+caps cluster control-socket cgroups debug doc +examples
extra-hardened gio hardened +highload-locks +inotify mhash
namespaces seccomp"

REQUIRED_USE="
	|| ( gio inotify )
	extra-hardened? ( hardened )
	mhash? ( cluster )"

RDEPEND="
	dev-libs/glib:2
	cgroups? ( dev-libs/libcgroup )
	mhash? ( app-crypt/mhash )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( ~app-doc/clsync-docs-${PV} )
"

pkg_pretend() {
	use namespaces && CONFIG_CHECK="~NAMESPACES ~UTS_NS ~IPC_NS ~USER_NS ~PID_NS ~NET_NS"
	use seccomp && CONFIG_CHECK+=" ~SECCOMP"
	check_extra_config
}

src_prepare() {
	# upstream fixes for 0.4
	epatch \
		"${FILESDIR}/${P}-gio.patch" \
		"${FILESDIR}/${P}-unshare-configure.patch" \
		"${FILESDIR}/${P}-unshare-ifdef.patch" \
		"${FILESDIR}/${P}-version.patch" \
		"${FILESDIR}/${P}-direct_mode.patch" \
		"${FILESDIR}/${P}-handler_path.patch" \
		"${FILESDIR}/${P}-hl_locks.patch" \
		"${FILESDIR}/${P}-unset_env.patch" \
		"${FILESDIR}/${P}-unused-deps.patch" \
		"${FILESDIR}/${P}-retries-arg.patch" \
		"${FILESDIR}/${P}-strtol.patch"
	eautoreconf
}

src_configure() {
	local harden_level=0
	use hardened && harden_level=1
	use extra-hardened && harden_level=2

	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--disable-socket-library \
		--enable-clsync \
		--enable-paranoid=${harden_level} \
		--without-bsm \
		--without-kqueue \
		$(use_enable caps capabilities) \
		$(use_enable cluster) \
		$(use_enable control-socket socket) \
		$(use_enable debug) \
		$(use_enable highload-locks) \
		$(use_enable namespaces unshare) \
		$(use_enable seccomp) \
		$(use_with cgroups libcgroup) \
		$(use_with gio gio lib) \
		$(use_with inotify inotify native) \
		$(use_with mhash)
}

src_install() {
	emake DESTDIR="${D}" install

	# remove unwanted docs
	rm "${ED}/usr/share/doc/${PF}/LICENSE" || die "failed to cleanup docs"
	use examples || rm -r "${ED}/usr/share/doc/${PF}/examples" || die "failed to remove examples"

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"

	# filter rules and sync scripts are supposed to be here
	keepdir "${EPREFIX}/etc/${PN}"
	insinto "/etc/${PN}"
	newins "${FILESDIR}/${PN}.conf" "${PN}.conf"
}

pkg_postinst() {
	einfo "${PN} is just a convenient way to run synchronization tools on live data,"
	einfo "it doesn't copy data itself, so you need to install software to do actual"
	einfo "data transfer. Usually net-misc/rsync is a good choise, but ${PN} is"
	einfo "is flexible enough to use any user tool, see manual page for details."
	einfo
	einfo "${PN} init script can be multiplexed, to use symlink init script to"
	einfo "othername and use conf.d/othername to configure it."
	einfo
	einfo "If you're interested in improved security, enable"
	einfo "USE=\"caps cgroups hardened namespaces seccomp\""
}
