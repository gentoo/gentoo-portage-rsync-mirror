# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/sun-templates/sun-templates-1.0.0.ebuild,v 1.1 2012/05/31 10:06:18 scarabeus Exp $

EAPI=4

OO_EXTENSIONS=(
	"472ffb92d82cf502be039203c606643d-Sun-ODF-Template-Pack-en-US_${PV}.oxt"
	"53ca5e56ccd4cab3693ad32c6bd13343-Sun-ODF-Template-Pack-de_${PV}.oxt"
	"4ad003e7bbda5715f5f38fde1f707af2-Sun-ODF-Template-Pack-es_${PV}.oxt"
	"a53080dc876edcddb26eb4c3c7537469-Sun-ODF-Template-Pack-fr_${PV}.oxt"
	"09ec2dac030e1dcd5ef7fa1692691dc0-Sun-ODF-Template-Pack-hu_${PV}.oxt"
	"b33775feda3bcf823cad7ac361fd49a6-Sun-ODF-Template-Pack-it_${PV}.oxt"
)
URI_EXTENSIONS="${OO_EXTENSIONS[@]/#/http://ooo.itc.hu/oxygenoffice/download/libreoffice/}"

inherit office-ext

DESCRIPTION="Collection of sun templates for various countries."
HOMEPAGE="http://ooo.itc.hu/oxygenoffice/download/libreoffice/"
SRC_URI="${URI_EXTENSIONS}"

LICENSE="sun-bcla-j2me"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# to avoid collisions
RDEPEND=">=app-office/libreoffice-l10n-3.5.4"
