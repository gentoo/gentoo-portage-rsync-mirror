# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-amqp/pecl-amqp-1.0.10.ebuild,v 1.2 2014/08/10 21:00:35 slyfox Exp $

EAPI=5

USE_PHP="php5-5 php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP Bindings for AMQP 0-9-1 compatible brokers"
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="net-libs/rabbitmq-c"
RDEPEND="${DEPEND}"
