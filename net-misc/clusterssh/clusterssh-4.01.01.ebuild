# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clusterssh/clusterssh-4.01.01.ebuild,v 1.6 2012/12/25 16:34:45 ago Exp $

EAPI=4

inherit eutils perl-module versionator

MY_PN="App-ClusterSSH"
MY_PV="$(replace_version_separator 2 _)"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Concurrent Multi-Server Terminal Access"
HOMEPAGE="http://clusterssh.sourceforge.net"
SRC_URI="mirror://sourceforge/clusterssh/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-perl/Exception-Class
	dev-perl/Readonly
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	dev-perl/Test-Trap
	dev-perl/Test-DistManifest
	dev-perl/Try-Tiny
	dev-perl/perl-tk
	dev-perl/Config-Simple
	dev-perl/X11-Protocol
	x11-apps/xlsfonts"
DEPEND="
	${RDEPEND}
	dev-perl/File-Which
	virtual/perl-Module-Build
	dev-perl/Test-Pod
	test? ( dev-perl/Test-Differences )"

S="${WORKDIR}"/${MY_P}

SRC_TEST="do parallel"

src_prepare() {
	# broken test, check again for new releases
	sed \
		-e '/boilerplate/d' \
		-e '/manifest.t/d' \
		-i MANIFEST || die
	rm t/boilerplate.t t/manifest.t || die

	epatch "${FILESDIR}"/${P}-testfix-1.patch
	perl-module_src_prepare
}
