# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ceph/ceph-0.56.5.ebuild,v 1.1 2013/05/09 21:07:35 alexxy Exp $

EAPI=5

if [[ $PV = *9999* ]]; then
	scm_eclass=git-2
	EGIT_REPO_URI="
		git://github.com/ceph/ceph.git
		https://github.com/ceph/ceph.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://ceph.com/download/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

inherit autotools eutils multilib udev ${scm_eclass}

DESCRIPTION="Ceph distributed filesystem"
HOMEPAGE="http://ceph.com/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug fuse gtk libatomic radosgw static-libs tcmalloc"

CDEPEND="
	dev-libs/boost
	dev-libs/fcgi
	dev-libs/libaio
	dev-libs/libedit
	dev-libs/crypto++
	sys-apps/keyutils
	fuse? ( sys-fs/fuse )
	libatomic? ( dev-libs/libatomic_ops )
	gtk? (
		x11-libs/gtk+:2
		dev-cpp/gtkmm:2.4
		gnome-base/librsvg
	)
	radosgw? (
		dev-libs/fcgi
		dev-libs/expat
		net-misc/curl
	)
	tcmalloc? ( dev-util/google-perftools )
	"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	sys-fs/btrfs-progs"

STRIP_MASK="/usr/lib*/rados-classes/*"

src_prepare() {
	sed -e 's:invoke-rc\.d.*:/etc/init.d/ceph reload >/dev/null:' \
		-i src/logrotate.conf || die
	sed -i "/^docdir =/d" src/Makefile.am || die #fix doc path
	# disable testsnaps
	sed -e '/testsnaps/d' -i src/Makefile.am || die
	sed -e "/bin=/ s:lib:$(get_libdir):" "${FILESDIR}"/${PN}.initd \
		> "${T}"/${PN}.initd || die
	sed -i -e '/AM_INIT_AUTOMAKE/s:-Werror ::' src/leveldb/configure.ac || die #423755
	eautoreconf
}

src_configure() {
	econf \
		--without-hadoop \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--includedir=/usr/include \
		$(use_with debug) \
		$(use_with fuse) \
		$(use_with libatomic libatomic-ops) \
		$(use_with radosgw) \
		$(use_with gtk gtk2) \
		$(use_enable static-libs static) \
		$(use_with tcmalloc)
}

src_install() {
	default

	prune_libtool_files --all

	rmdir "${ED}/usr/sbin"

	exeinto /usr/$(get_libdir)/ceph
	newexe src/init-ceph ceph_init.sh

	insinto /etc/logrotate.d/
	newins src/logrotate.conf ${PN}

	chmod 644 "${ED}"/usr/share/doc/${PF}/sample.*

	keepdir /var/lib/${PN}
	keepdir /var/lib/${PN}/tmp
	keepdir /var/log/${PN}/stat

	newinitd "${T}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}

	# install udev rules
	udev_dorules udev/50-rbd.rules
}
