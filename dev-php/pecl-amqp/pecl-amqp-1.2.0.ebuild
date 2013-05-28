# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-amqp/pecl-amqp-1.2.0.ebuild,v 1.1 2013/05/28 11:39:49 olemarkus Exp $

EAPI=5

USE_PHP="php5-3 php5-4 php5-5"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP Bindings for AMQP 0-9-1 compatible brokers."
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="net-libs/rabbitmq-c"
RDEPEND="${DEPEND}"
