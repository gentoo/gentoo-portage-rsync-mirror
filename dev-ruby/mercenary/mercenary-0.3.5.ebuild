# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mercenary/mercenary-0.3.5.ebuild,v 1.1 2014/11/13 16:35:15 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="History.markdown README.md"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Lightweight and flexible library for writing command-line apps"
HOMEPAGE="https://github.com/jekyll/mercenary"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
