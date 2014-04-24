# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/columnize/columnize-0.3.6-r1.ebuild,v 1.3 2014/04/24 20:13:17 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="AUTHORS ChangeLog NEWS README.md"

inherit ruby-fakegem

DESCRIPTION="Sorts an array in column order."
HOMEPAGE="http://rubyforge.org/projects/rocky-hacks/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""
