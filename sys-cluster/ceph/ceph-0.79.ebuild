# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ceph/ceph-0.79.ebuild,v 1.1 2014/04/17 23:51:20 dlan Exp $

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
	KEYWORDS=""
fi

inherit autotools eutils multilib python-any-r1 udev ${scm_eclass}

DESCRIPTION="Ceph distributed filesystem"
HOMEPAGE="http://ceph.com/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="cryptopp debug fuse gtk libatomic +libaio libxfs libzfs +nss radosgw static-libs tcmalloc"

CDEPEND="
	app-arch/snappy
	dev-libs/boost:=[threads]
	dev-libs/fcgi
	dev-libs/libaio
	dev-libs/libedit
	dev-libs/leveldb[snappy]
	nss? ( dev-libs/nss )
	cryptopp? ( dev-libs/crypto++ )
	sys-apps/keyutils
	sys-apps/util-linux
	dev-libs/libxml2
	fuse? ( sys-fs/fuse )
	libatomic? ( dev-libs/libatomic_ops )
	libxfs? ( sys-fs/xfsprogs )
	libzfs? ( sys-fs/zfs )
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
	$(python_gen_any_dep '
	virtual/python-argparse[${PYTHON_USEDEP}]
	' )
	${PYTHON_DEPS}
	"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	sys-apps/hdparm
	$(python_gen_any_dep '
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	' )"
REQUIRED_USE="
	^^ ( nss cryptopp )
	"

STRIP_MASK="/usr/lib*/rados-classes/*"

PATCHES=(
	"${FILESDIR}"/${PN}-fix-gnustack.patch
	"${FILESDIR}"/${P}-libzfs.patch
)

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	[[ ${PATCHES[@]} ]] && epatch "${PATCHES[@]}"

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
		$(use_with nss) \
		$(use_with cryptopp) \
		$(use_with radosgw) \
		$(use_with gtk gtk2) \
		$(use_enable static-libs static) \
		$(use_with tcmalloc) \
		$(use_with libxfs) \
		$(use_with libzfs)
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

	_python_rewrite_shebang \
		"${ED}"/usr/sbin/{ceph-disk,ceph-create-keys} \
		"${ED}"/usr/bin/{ceph,ceph-rest-api}

	#install udev rules
	udev_dorules udev/50-rbd.rules
	udev_dorules udev/95-ceph-osd.rules
}

pkg_postinst() {
	elog "We suggest to install following packages"
	elog " sys-block/parted		to manage disk partions"
	elog " sys-fs/btrfs-progs	to use btrfs filesytem"
	elog " sys-fs/cryptsetup	to use encrypted devices with dm-crypt"
}
