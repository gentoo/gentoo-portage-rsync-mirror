# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.16.6_p3.ebuild,v 1.1 2011/01/16 20:51:19 hwoarang Exp $

EAPI="2"

inherit eutils autotools

DEB_PL="${P##*_p}"
MY_P="${P%%_*}"
MY_P="${MY_P/-/_}"
DESCRIPTION="Maintain remote web sites with ease"
SRC_URI="mirror://debian/pool/main/s/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/s/${PN}/${MY_P}-${DEB_PL}.diff.gz"
HOMEPAGE=" http://www.manyfish.co.uk/sitecopy/ http://packages.debian.org/unstable/sitecopy"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

LICENSE="GPL-2"
SLOT="0"
IUSE="expat nls rsh ssl webdav xml zlib"

DEPEND="rsh? ( net-misc/netkit-rsh )
	>=net-libs/neon-0.24.6[zlib?,ssl?,expat?]
	xml? ( >=net-libs/neon-0.24.6[-expat] )"

RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P/_/-}

src_prepare() {
	cd "${WORKDIR}" || die
	# Debian patches
	epatch ${MY_P}-${DEB_PL}.diff

	cd "${S}" || die
	epatch "${S}"/debian/patches/*.dpatch

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
