# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/colorator/colorator-0.1-r1.ebuild,v 1.1 2013/10/09 01:31:58 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.markdown"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Colorize your text in the terminal"
HOMEPAGE="https://github.com/octopress/colorator"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
