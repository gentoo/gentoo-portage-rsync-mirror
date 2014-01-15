# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ceph/ceph-0.72.2-r1.ebuild,v 1.1 2014/01/15 13:45:32 dlan Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

if [[ $PV = *9999* ]]; then
	scm_eclass=git-r3
	EGIT_REPO_URI="
		git://github.com/ceph/ceph.git
		https://github.com/ceph/ceph.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://ceph.com/download/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

inherit autotools eutils multilib python-r1 udev ${scm_eclass}

DESCRIPTION="Ceph distributed filesystem"
HOMEPAGE="http://ceph.com/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug fuse gtk libatomic +libaio radosgw static-libs tcmalloc"

CDEPEND="
	app-arch/snappy
	dev-libs/boost[threads]
	dev-libs/fcgi
	dev-libs/libaio
	dev-libs/libedit
	dev-libs/leveldb[snappy]
	dev-libs/crypto++
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	sys-apps/keyutils
	sys-apps/hdparm
	sys-apps/util-linux
	sys-block/parted
	sys-fs/cryptsetup
	dev-libs/libxml2
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
	virtual/python-argparse[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
	"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	sys-fs/btrfs-progs"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

STRIP_MASK="/usr/lib*/rados-classes/*"

src_prepare() {
	if [ ! -z ${PATCHES[@]} ]; then
		epatch ${PATCHES[@]}
	fi
	sed -e "/bin=/ s:lib:$(get_libdir):" "${FILESDIR}"/${PN}.initd \
		> "${T}"/${PN}.initd || die

	epatch_user
	eautoreconf
}

src_configure() {
	econf \
		--without-hadoop \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--includedir=/usr/include \
		$(use_with debug) \
		$(use_with fuse) \
		$(use_with libaio) \
		$(use_with libatomic libatomic-ops) \
		$(use_with radosgw) \
		$(use_with gtk gtk2) \
		$(use_enable static-libs static) \
		$(use_with tcmalloc)
}

src_install() {
	default

	prune_libtool_files --all

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

	python_replicate_script \
		"${ED}"/usr/sbin/{ceph-disk,ceph-create-keys} \
		"${ED}"/usr/bin/{ceph,ceph-rest-api}

	#install udev rules
	udev_dorules udev/50-rbd.rules
	udev_dorules udev/95-ceph-osd.rules
}
