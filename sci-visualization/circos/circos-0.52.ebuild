# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/circos/circos-0.52.ebuild,v 1.1 2010/05/01 20:33:15 weaver Exp $

EAPI="2"

inherit perl-module

DESCRIPTION="Circular layout visualization of genomic and other data"
HOMEPAGE="http://mkweb.bcgsc.ca/circos/"
SRC_URI="http://mkweb.bcgsc.ca/circos/distribution/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Clone
	dev-perl/GD
	dev-perl/Math-Bezier
	dev-perl/Math-Round
	dev-perl/Math-VecStat
	dev-perl/Params-Validate
	dev-perl/Readonly
	>=dev-perl/Set-IntSpan-1.11
	dev-perl/Graphics-ColorObject
	dev-perl/List-MoreUtils
	dev-perl/Class-Base
	dev-perl/config-general
	virtual/perl-Module-Build"
RDEPEND="${DEPEND}"
