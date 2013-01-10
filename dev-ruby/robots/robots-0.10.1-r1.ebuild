# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/robots/robots-0.10.1-r1.ebuild,v 1.1 2013/01/10 07:46:05 graaff Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="A simple Ruby library to parse robots.txt"
HOMEPAGE="https://rubygems.org/gems/robots"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
