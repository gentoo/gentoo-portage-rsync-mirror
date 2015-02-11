# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libclsync/libclsync-0.4.ebuild,v 1.1 2015/02/11 03:35:23 bircoph Exp $

EAPI=5

MY_PN=${PN#lib}
MY_P="${MY_PN}-${PV}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xaionaro/${MY_PN}.git"
else
	SRC_URI="https://github.com/xaionaro/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

inherit autotools eutils

DESCRIPTION="Control and monitoring library for clsync"
HOMEPAGE="http://ut.mephi.ru/oss/clsync https://github.com/xaionaro/clsync"
LICENSE="GPL-3+"
SLOT="0"
IUSE="debug doc extra-hardened hardened static-libs"
REQUIRED_USE="
	extra-hardened? ( hardened )
"

DEPEND="
	virtual/pkgconfig
	doc? ( ~app-doc/clsync-docs-${PV} )
"

src_prepare() {
	epatch "${FILESDIR}/${P}-version.patch"
	eautoreconf
}

src_configure() {
	local harden_level=0
	use hardened && harden_level=1
	use extra-hardened && harden_level=2

	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--enable-socket-library \
		--disable-clsync \
		--enable-paranoid=${harden_level} \
		--without-bsm \
		--without-kqueue \
		--disable-cluster \
		--enable-socket \
		$(use_enable debug) \
		--disable-highload-locks \
		--without-capabilities \
		--without-libcgroup \
		--without-gio \
		--with-inotify=native \
		--without-mhash \
		--without-libseccomp
}

src_install() {
	emake DESTDIR="${D}" install
	prune_libtool_files
	use static-libs || find "${ED}" -name "*.a" -delete || die "failed to remove static libs"

	# remove unwanted docs
	rm "${ED}/usr/share/doc/${PF}"/{LICENSE,TODO} || die "failed to cleanup docs"
	rm -r "${ED}/usr/share/doc/${PF}/examples" || die "failed to remove examples"
}

pkg_postinst() {
	einfo "clsync instances you are going to use _must_ be compiled"
	einfo "with control-socket support"
}
