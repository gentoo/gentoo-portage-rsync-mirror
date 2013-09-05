# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Exporter/perl-Exporter-5.680.0.ebuild,v 1.1 2013/09/05 05:37:38 patrick Exp $

DESCRIPTION="Virtual for perl-core/Exporter"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	|| (
		(
			~dev-lang/perl-5.17.11
			!perl-core/Exporter
		)
		~perl-core/Exporter-${PV}
	)
"
