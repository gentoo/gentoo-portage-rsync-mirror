# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cdk-perl/cdk-perl-20130816.ebuild,v 1.2 2014/11/02 08:16:00 zlogene Exp $

EAPI=5

inherit perl-module

DESCRIPTION="Perl extension for Cdk"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/cdk-5.0.20090215"
DEPEND="${RDEPEND}"

src_configure() {
	default
	perl-module_src_configure
}
