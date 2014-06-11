# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/delayer/delayer-0.0.2.ebuild,v 1.1 2014/06/11 07:39:01 naota Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem
DESCRIPTION="Delay the processing"
HOMEPAGE="https://rubygems.org/gems/delayer"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/bundler/d' Rakefile ${PN}.gemspec || die "sed failed"
}
