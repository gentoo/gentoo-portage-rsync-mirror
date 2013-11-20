# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/warden/warden-1.2.3.ebuild,v 1.1 2013/11/20 15:25:26 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.textile History.rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="General Rack Authentication Framework"
HOMEPAGE="https://github.com/hassox/warden"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_rdepend "dev-ruby/rack"
