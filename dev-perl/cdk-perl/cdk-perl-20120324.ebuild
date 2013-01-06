# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cdk-perl/cdk-perl-20120324.ebuild,v 1.5 2012/10/02 01:02:17 blueness Exp $

EAPI=4

inherit perl-module

DESCRIPTION="Perl extension for Cdk"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/cdk-4.9.10.20031210"
DEPEND="${RDEPEND}"

src_configure() {
	default
	perl-module_src_configure
}
