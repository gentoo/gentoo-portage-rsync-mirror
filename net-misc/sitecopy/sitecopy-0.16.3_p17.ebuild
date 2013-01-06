# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.16.3_p17.ebuild,v 1.7 2010/06/22 20:06:49 arfrever Exp $

EAPI="2"

inherit eutils autotools

IUSE="expat nls rsh ssl webdav xml zlib"

DEB_PL="${P##*_p}"
MY_P="${P%%_*}"
MY_P="${MY_P/-/_}"
DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="mirror://debian/pool/main/s/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/s/${PN}/${MY_P}-${DEB_PL}.diff.gz"
HOMEPAGE="http://packages.debian.org/unstable/sitecopy http://www.lyra.org/sitecopy/"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"

LICENSE="GPL-2"
SLOT="0"
DEPEND="rsh? ( net-misc/netkit-rsh )
	>=net-libs/neon-0.24.6[zlib?,ssl?,expat?]
	xml? ( >=net-libs/neon-0.24.6[-expat] )"

S="${WORKDIR}"/${MY_P/_/-}

src_prepare() {
	cd "${WORKDIR}" || die
	# Debian patches
	epatch ${MY_P}-${DEB_PL}.diff
	epatch "${S}"/debian/patches/*.dpatch

	cd "${S}" || die

	# Make it work with neon .29
	epatch "${FILESDIR}"/${PV}-neon-29.patch

	sed -i -e \
		"s:docdir \= .*:docdir \= \$\(prefix\)\/share/doc\/${PF}:" \
		Makefile.in || die "Documentation directory patching failed"

	eautoconf
	eautomake
}

src_configure() {
	econf \
			$(use_with ssl ssl openssl) \
			$(use_enable webdav) \
			$(use_enable nls) \
			$(use_enable rsh) \
			$(use_with expat) \
			$(use_with xml libxml2 ) \
			--with-neon \
			|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
