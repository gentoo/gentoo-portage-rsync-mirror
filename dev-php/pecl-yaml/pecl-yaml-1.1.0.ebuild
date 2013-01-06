# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-yaml/pecl-yaml-1.1.0.ebuild,v 1.1 2012/05/20 15:50:14 olemarkus Exp $

EAPI="4"

PHP_EXT_NAME="yaml"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CREDITS EXPERIMENTAL README"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Support for YAML 1.1 (YAML Ain't Markup Language) serialization
using the LibYAML library."
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libyaml-0.1.0"
RDEPEND="${DEPEND}"
