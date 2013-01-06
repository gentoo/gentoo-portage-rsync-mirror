# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_Weather/PEAR-Services_Weather-1.4.5.ebuild,v 1.7 2012/03/07 18:48:49 ranger Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="This class acts as an interface to various online weather-services"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE="minimal"
DEPEND="|| ( <dev-lang/php-5.3[ctype,pcre] >=dev-lang/php-5.3[ctype] )"
RDEPEND=">=dev-php/PEAR-HTTP_Request-1.2.4-r1
	!minimal? ( >=dev-php/PEAR-Cache-1.5.4-r1
		    >=dev-php/PEAR-DB-1.7.6-r1
		    >=dev-php/PEAR-SOAP-0.8.1-r1
		    >=dev-php/PEAR-XML_Serializer-0.15.0-r1
		    >=dev-php/PEAR-Net_FTP-1.3.1 )"
