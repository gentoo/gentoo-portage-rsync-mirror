# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/robots/robots-0.10.1-r2.ebuild,v 1.2 2014/05/21 01:44:01 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="A simple Ruby library to parse robots.txt"
HOMEPAGE="https://rubygems.org/gems/robots"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
