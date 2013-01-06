# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/cvmfs/cvmfs-2.0.19.ebuild,v 1.1 2012/10/30 14:44:26 bicatali Exp $

EAPI=4

inherit eutils autotools toolchain-funcs linux-mod

DESCRIPTION="HTTP read-only file system for distributing software"
HOMEPAGE="http://cernvm.cern.ch/portal/filesystem"
SRC_URI="https://ecsft.cern.ch/dist/${PN}/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="+client doc openmp server"

CDEPEND="dev-db/sqlite:3
	dev-libs/openssl
	sys-libs/zlib
	client? (
		dev-libs/jemalloc
		net-misc/curl
		sys-fs/fuse )
	server? ( >=sys-fs/redirfs-0.10.20120313 )"

RDEPEND="${CDEPEND}
	client? ( net-fs/autofs )"

DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen[dot] )"

# either client or server is required and are mutually exclusive
REQUIRED_USE="^^ ( client server )"

pkg_setup() {
	if use server && use openmp && [[ $(tc-getCC) == *gcc* ]] && ! tc-has-openmp
	then
		ewarn "You are using a gcc without OpenMP capabilities"
		die "Need an OpenMP capable compiler"
	fi
	if use server; then
		MODULE_NAMES="cvmfsflt(misc:${S}/kernel/cvmfsflt/src)"
		BUILD_PARAMS="-C ${KERNEL_DIR} M=${S}/kernel/cvmfsflt/src"
		BUILD_TARGETS="cvmfsflt.ko"
		linux-mod_pkg_setup
	fi
}

src_prepare() {
	#	"${FILESDIR}"/${P}-system-redirfs.patch \
	epatch \
		"${FILESDIR}"/${P}-autotools.patch \
		"${FILESDIR}"/${P}-no-redhat-init.patch \
		"${FILESDIR}"/${P}-spinlock.patch \
		"${FILESDIR}"/${P}-openrc.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-sqlite3-builtin \
		--disable-libcurl-builtin \
		--disable-zlib-builtin \
		--disable-jemalloc-builtin \
		$(use_enable client cvmfs) \
		$(use_enable client mount-scripts) \
		$(use_enable openmp) \
		$(use_enable server)
}

src_compile() {
	emake
	if use server; then
		ln -s "${EROOT}"/usr/include/redirfs.h "${S}"/kernel/cvmfsflt/src
		linux-mod_src_compile
	fi
	use doc && doxygen doc/cvmfs.doxy
}

src_install() {
	default
	# NEWS file is empty
	rm "${ED}"/usr/share/doc/${PF}/{INSTALL,NEWS,COPYING}

	use client && newinitd "${FILESDIR}"/${PN}.initd ${PN}
	if use server; then
		linux-mod_src_install
		newinitd "${FILESDIR}"/${PN}d.initd ${PN}d
		newconfd "${FILESDIR}"/${PN}d.confd ${PN}d
	fi
	use doc && dohtml -r doc/html/*
}

pkg_preinst() {
	use server && linux-mod_pkg_preinst
}

pkg_postinst() {
	use server && linux-mod_pkg_postinst
}

pkg_postrm() {
	use server && linux-mod_pkg_postrm
}

pkg_config() {
	if use client; then
		einfo "Setting up CernVM-FS client"
		cvmfs_config setup
		cat > "${EROOT}"/etc/cvmfs/default.local <<-EOF
			# Repositories to fetch example is for ATLAS
			CVMFS_REPOSITORIES=atlas.cern.ch,atlas-condb.cern.ch,grid.cern.ch
			# Local proxy settings, ex: http://cernvm.cern.ch/config/proxy.cgi
			CVMFS_HTTP_PROXY="DIRECT"
			# Where to keep the cvmfs cache
			CVMFS_CACHE_BASE=${EROOT}/var/scratch/cvmfs
			# Quota limit in Mb
			CVMFS_QUOTA_LIMIT=10000
		EOF
		einfo "Now edit ${EROOT}/etc/cvmfs/default.local and run"
		einfo "  ${EROOT}/usr/init.d/cvmfs restart"
	fi
}
